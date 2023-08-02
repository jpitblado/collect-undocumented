# Collect undocumentation

The `collect` commands are built upon Mata functions.  StataCorp may
document these Mata functions (or maybe an intermediate Mata class
layer) someday, but in the interim this repository contains the basic
notes and examples a Stata/Mata programmer needs to access the `collect`
internals that are not already provided by the Stata command `collect`.

## Name of the current collection

Get the name of the current collection with `_collect_current()`.
```
cid = _collect_current()
```
Here `cid` is a string scalar with the name of the current collection.

## Verify a collection name

Verify that a collection name is valid with `_collect_require()`.
```
rc = _collect_require(cid)
```
`rc` is a real scalar and contains a non-zero value if the function
exits with an error.  This is true of all the following fuctions.

## Number of tables in the current layout

Get the number of tables for the current layout with `_collect_tabs()`.
```
rc = _collect_tabs(cid, nt=0)
```
Here `nt` is a real scalar (initialized by you to 0) and is changed by
`_collect_tabs()` to contain the number of tables in the collection
identified by `cid`.

## Title

Get the collection's title with `_collect_get_title()`.
```
rc = _collect_get_title(cid, title="")
```
Here `title` is a string scalar (initialized by you to the empty string),
and is changed by this function to contain the title in the
collection identified by `cid`.

## Notes

Get the collection's notes with `_collect_get_notes()`.
```
rc = _collect_get_notes(cid, notes=J(1,0,""))
```
Here `notes` is a string vector (initialized by you to be empty),
and is changed by this function to contain the notes in the
collection identified by `cid`.

## Stars note

Get the collection's stars note with `_collect_get_stars_note()`.
```
rc = _collect_get_stars_note(cid, stars_note="")
```
Here `stars_note` is a string scalar (initialized by you to the empty
string) and is changed by this function to contain the stars note in
the collection identified by `cid`.

## Table header

In addition to the title, when a layout yields more than one table, each
table has its own header constructed from the table specification in the
layout.

Get a table's header with `_collect_get_tab_header()`.
```
rc = _collect_get_tab_header(cid, t, th="")
```
Here `t` is a real scalar that selects a table in collection `cid`
(`t=1,2,...nt`), and `th` is a string scalar (initialized by you to the
empty string) and is changed by this function to contain the table
header.  When a layout yields a single table, `th` is set to the empty
string.

## Table row headers

Get a table's row headers with `_collect_get_row_headers()`.
```
rc = _collect_get_row_headers(cid, t, rh=J(0,0,""))
```
Here `t` is a table index in collection `cid`, and `rh` is a string
matrix (initialized by you to an empty matrix) and is changed by this
function to contain the table's row headers.  When `collect style row split`
is in effect, `rh` could be a column vector or a matrix.  When `collect style
row stack` is in effect, `rh` is always a column vector.

## Table column headers

Get a table's column headers with `_collect_get_col_headers()`.
```
rc = _collect_get_col_headers(cid, t, ch=J(0,0,""))
```
Here `t` is a table index in collection `cid`, and `ch` is a string
matrix (initialized by you to an empty matrix) and is changed by this
function to contain the table's column headers.

Each row represents a column header, so `ch` is actually the transpose
of what is shown by `collect layout` or `collect preview`.

## Item values: numeric and string

Get a table's numeric cell items with `_collect_get_item_values()`.
```
rc = _collect_get_item_values(cid, t, nv=J(0,0,.))
```
Here `t` is a table index in collection `cid`, `nv` is a real matrix
(initialized by you to an empty matrix) and is changed by this function to
contain the table's numeric cell values.  This matrix is not populated by
composite results.

Get a table's string cell items with `_collect_get_items()`.
```
rc = _collect_get_items(cid, t, sv=J(0,0,""))
```
Here `t` is a table index in collection `cid`, `sv` is a string matrix
(initialized by you to an empty matrix) and is changed by this function
to contain the table's string cell values.  This matrix is
populated by string items, formatted numeric items, and composite results.

The `sformat()` style property is not applied to these cells, that is
left for the programmer.  However, when composite results are composed,
their elements are formatted according to their `nformat()` and
`sformat()` style properties.

## Styles

### Block styles

In order to add borders between blocks, `collect` allows you to specify
block styles using dimesion `border_block`.  You can also use this
dimension to specify block-specific style defaults.

Get the block styles for corner, row-header, column-header, and item
with `_collect_get_block_styles()`.
```
rc = _collect_get_block_styles(cid, "corner", t, sty=J(0,2,""))
rc = _collect_get_block_styles(cid, "row-header", t, sty=J(0,2,""))
rc = _collect_get_block_styles(cid, "column-header", t, sty=J(0,2,""))
rc = _collect_get_block_styles(cid, "item", t, sty=J(0,2,""))
```
Here `t` is a table index in collection `cid`, the second argument
specifies the block, and `sty` is a string matrix (initialized by
you to an empty matrix) and is changed by this function to contain the
block styles.

`sty` is a 2 column matrix of key-value pairs; the first column is the
key and identifies a style property, the second column is the value of
the style property.

The `collect` system only pays attention to the border style elements in
`sty`.  All other style properties are retrieved for each cell in each
block of each table.

### Cell styles

Within each block, `collect` also supports cell-specific styles.

In the following discussion, I will rely on the following definitions.
```
nrh = cols(rh)
nch = cols(ch)
nir = rows(sv)
nic = cols(sv)
```
Also note the following are assumed true.
```
assert(rows(rh) == nir)
assert(rows(ch) == nic)
```

#### Corner cell styles

Get corner cell styles with `_collect_get_corner_styles()`.
```
rc = _collect_get_corner_styles(cid, i, j, t, sty=J(0,2,""))
```
Here `i` (1,...,nch) is the row index and `j` (1,...,nrh) is the column
index for elements of the corner.

`sty` is a 2 column matrix of key-value pairs; the first column is the
key and identifies a style property, the second column is the value of
the style property.

Currently there is now way to put text in the corner, so the corner cell
styles can only affect borders and background colors.

#### Row header cell styles

Get row header cell styles with `_collect_get_row_header_styles()`.
```
rc = _collect_get_row_header_styles(cid, i, j, t, sty=J(0,2,""))
```
Here `i` (1,...,nir) is the row index and `j` (1,...,nrh) is the column
index for elements of the row header for table `t` in collection `cid`.

`sty` is a 2 column matrix of key-value pairs; the first column is the
key and identifies a style property, the second column is the value of
the style property.

#### Colunn header cell styles

Get column header cell styles with `_collect_get_col_header_styles()`.
```
rc = _collect_get_col_header_styles(cid, j, i, t, sty=J(0,2,""))
```
Here `i` (1,...,nch) is the row index and `j` (1,...,nic) is the column
index for elements of the column header for table `t` in collection `cid`.

Recall that the column headers returned by `_collect_get_col_headers()`
are the transpose of what you see from `collect layout` and `collect
preview`.

`sty` is a 2 column matrix of key-value pairs; the first column is the
key and identifies a style property, the second column is the value of
the style property.

#### Item cell styles

Get item cell styles with `_collect_get_items_styles()`.
```
rc = _collect_get_item_styles(cid, i, j, t, sty=J(0,2,""))
```
Here `i` (1,...,nir) is the row index and `j` (1,...,nic) is the column
index for elements of the items for table `t` in collection `cid`.

`sty` is a 2 column matrix of key-value pairs; the first column is the
key and identifies a style property, the second column is the value of
the style property.

