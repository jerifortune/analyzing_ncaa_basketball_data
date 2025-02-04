# This function accepts a string with repeated letter  and output each letter with the number of occurance . 
# Example 'aabbbdd' will output a2b3d2

def letterCount(st):
    st = str(st)
    ls = set(st)
    rst = [x +str(st.count(x)) for x in ls]
    rst = list(rst)
# convert the list to string using join
    strg = ''.join(rst)
    return  strg

print(letterCount('aaaabbccc'))