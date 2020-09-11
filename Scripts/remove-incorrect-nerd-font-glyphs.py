import fontforge
from sys import argv

font = fontforge.open(argv[1])
font.removeGlyph(ord('\ufb01'))
font.removeGlyph(ord('\ufb02'))
font.generate(argv[2])