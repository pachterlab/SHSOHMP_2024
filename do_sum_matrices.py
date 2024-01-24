import sys


def do_sum_matrices(
    mtx1_path, mtx2_path, out_path, header_line=None 
) -> str:
    """Sums up two matrices given two matrix files.

    Args:
        mtx1_path: First matrix file path
        mtx2_path: Second matrix file path
        out_path: Output file path
        header_line: The header line if we have it

    Returns:
        Output file path
    """
    n = 0
    total_n = 0
    header = []
    with open(mtx1_path, 'r') as f1, open(
        mtx2_path, 'r') as f2, open(out_path, 'w') as out:
        eof1 = eof2 = False
        nums = [0,0,0]
        nums1 = nums2 = None
        pause1 = pause2 = False
        to_write = None
        if header_line:
            out.write("%%MatrixMarket matrix coordinate real general\n%\n")
        while not eof1 or not eof2:
            s1 = f1.readline() if not eof1 and not pause1 else '%'
            s2 = f2.readline() if not eof2 and not pause2 else '%'
            if not s1:
                pause1 = True
                eof1 = True
            if not s2:
                pause2 = True
                eof2 = True
            _nums1 = list(map(int, s1.split() if not eof1 and s1[0] != '%' else []))
            _nums2 = list(map(int, s2.split() if not eof2 and s2[0] != '%' else []))
            if nums1 is not None:
                _nums1 = nums1
                nums1 = None
            if nums2 is not None:
                _nums2 = nums2
                nums2 = None
            if (eof1 and eof2):
                # Both mtxs are done
                break
            elif (eof1):
                # mtx1 is done
                nums = _nums2
                pause2 = False
            elif (eof2):
                # mtx2 is done
                nums = _nums1
                pause1 = False
            elif (eof1 and eof2):
                # Both mtxs are done
                break
            elif (len(_nums1) != len(_nums2)):
                # We have a problem
                raise Exception("Summing up two matrix files failed")
            elif (len(_nums1) != 3) or (len(_nums2) != 3):
                # We have something other than a matrix line
                continue
            elif (len(header) == 0):
                # We are at the header line and need to read it in
                if (_nums1[0] != _nums2[0] or _nums1[1] != _nums2[1]):
                    raise Exception("Summing up two matrix files failed: Headers incompatible")
                else:
                    header = [_nums1[0], _nums1[1]]
                total_n = _nums1[2] + _nums2[2]
                if header_line:
                    out.write(header_line)
                continue
            elif (_nums1[0] > _nums2[0] or (_nums1[0] == _nums2[0] and _nums1[1] > _nums2[1])):
                # If we're further in mtx1 than mtx2
                nums = _nums2
                pause1 = True
                pause2 = False
                nums1 = _nums1
                nums2 = None
            elif (_nums2[0] > _nums1[0] or (_nums2[0] == _nums1[0] and _nums2[1] > _nums1[1])):
                # If we're further in mtx2 than mtx1
                nums = _nums1
                pause2 = True
                pause1 = False
                nums2 = _nums2
                nums1 = None
            elif (_nums1[0] == _nums2[0] and _nums1[1] == _nums2[1]):
                # If we're at the same location in mtx1 and mtx2
                nums = _nums1
                nums[2] += _nums2[2]
                pause1 = False
                pause2 = False
                nums1 = None
                nums2 = None
            else:
                # Shouldn't happen
                raise Exception("Summing up two matrix files failed: Assertion failed")
            # Write out a line
            _nums_prev = None if not to_write else list(map(int, to_write.split()))
            if (_nums_prev and _nums_prev[0] == nums[0] and _nums_prev[1] == nums[1]):
                nums[2] += _nums_prev[2]
                pause1 = False
                pause2 = False
                to_write = f'{nums[0]} {nums[1]} {nums[2]}\n'
            else:
                if to_write:
                    if header_line:
                        out.write(to_write)
                    n += 1
                to_write = f'{nums[0]} {nums[1]} {nums[2]}\n'
        if to_write:
            if header_line:
                out.write(to_write)
            n += 1
    if not header_line:
        header_line = f'{header[0]} {header[1]} {n}\n'
        do_sum_matrices(mtx1_path, mtx2_path, out_path, header_line)
    return out_path

do_sum_matrices(sys.argv[1], sys.argv[2], sys.argv[3])
