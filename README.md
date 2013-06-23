NSString-TruncatedWidth
=======================

This is a simple NSString Category for seperating NSString into components given width and font for multiline formatting. I used for adding text width adjusted background to multiline text.

### Usage
	[@"This is your multi-lined string" componentsSeparatedByWidth:100.0 forFont:[UIFont systemFontOfSize:12] maxStrings:NSIntegerMax]