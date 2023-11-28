{
    if (/Card: Original:/) {
        print prevLine
        print $0 
    }
    prevLine = $0
}