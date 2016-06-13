def index(elem, seq):
    if not seq:
        return None 
    if elem==seq[0]:
        return 0
    res =  index(elem,seq[1:])

    return None if res is None else 1 + res
