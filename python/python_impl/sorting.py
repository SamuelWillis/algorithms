def insertion_sort(arr):
    for i, value in enumerate(arr):
        j = i - 1

        while j >= 0 and value < arr[j]:
            arr[j + 1] = arr[j]
            j = j - 1

        arr[j + 1] = value

    return arr
