function b3check
    set -l print_hash 0
    set -l files
    for a in $argv
        if test "$a" = "--print-hash"
            set print_hash 1
        else
            set files $files $a
        end
    end

    if not type -q b3sum
        echo "Error: b3sum not found. Install on Arch/CachyOS:"
        echo "  sudo pacman -S b3sum"
        return 1
    end

    if test (count $files) -lt 2
        echo "Usage: b3check [--print-hash] <ref_file> <file2> [file3 ...]"
        return 1
    end

    function __b3_of --argument file
        b3sum -- $file 2>/dev/null | grep -Eio '^[0-9a-f]{64}' | head -n1
    end

    function __size_bytes --argument file
        # GNU coreutils on Arch: use -c (lowercase). -- to stop option parsing.
        stat -c %s -- $file 2>/dev/null
    end

    function __now_ns
        date +%s%N
    end

    set -l ref $files[1]
    if not test -f $ref
        echo "Error: $ref not found"
        return 1
    end

    set -l ref_hash (__b3_of $ref)
    if test -z "$ref_hash"
        echo "Error: failed to compute hash for $ref"
        return 1
    end

    echo ""
    echo "Using b3sum (BLAKE3)"
    echo ""
    echo "Reference:"
    echo "  $ref"
    if test $print_hash -eq 1
        echo "  $ref_hash"
    end
    echo ""
    echo "-----------------------------------"
    echo ""

    set -l match 0
    set -l diff 0

    for f in $files[2..-1]
        if not test -f $f
            echo "Error: $f not found"
            continue
        end

        set -l size (__size_bytes $f)
        if test -z "$size"
            set size 0
        end

        set -l t0 (__now_ns)
        set -l h (__b3_of $f)
        set -l t1 (__now_ns)

        set -l elapsed_ns (math "$t1 - $t0")
        if test $elapsed_ns -le 0
            set elapsed_ns 1
        end

        set -l secs (math "$elapsed_ns / 1e9")
        if test "$secs" = "0"
            set secs 0.000001
        end
        set -l mbps (math --scale 2 "($size/1048576)/$secs")

        if test -n "$h" -a "$h" = "$ref_hash"
            if test $print_hash -eq 1
                echo "$f"
                echo "  MATCH      $h"
                printf "  Speed:     %.2f MB/s\n\n" $mbps
            else
                printf "%s  MATCH  (%.2f MB/s)\n\n" "$f" $mbps
            end
            set match (math $match + 1)
        else
            if test $print_hash -eq 1
                echo "$f"
                echo "  DIFFERENT  $h"
                printf "  Speed:     %.2f MB/s\n\n" $mbps
            else
                printf "%s  DIFFERENT  (%.2f MB/s)\n\n" "$f" $mbps
            end
            set diff (math $diff + 1)
        end
    end

    echo "-----------------------------------"
    echo ""
    echo "Summary:"
    echo "  $match MATCH"
    echo "  $diff DIFFERENT"
    echo ""
end
