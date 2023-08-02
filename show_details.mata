* show_details.mata

set matastrict on

mata:

function show_details()
{
	string	scalar	cid
	real	scalar	rc
	real	scalar	nt
	string	scalar	note
	real	scalar	t
	string	matrix	th
	string	matrix	rh
	string	matrix	ch
	real	matrix	nv
	string	matrix	sv
	real	scalar	nrh
	real	scalar	nch
	real	scalar	nir
	real	scalar	nic
	string	matrix	sty
	real	scalar	i
	real	scalar	j

	cid = _collect_current()
	printf("{txt}cid is %s\n", cid)
	rc = _collect_tabs(cid, nt=0)
	printf("{txt}nt is %f\n", nt)
	rc = _collect_get_stars_note(cid, note="")
	printf("{txt}stars note is '%s'\n", note)
	for (t=1; t<=nt; t++) {
		rc = _collect_get_tab_header(cid, t, th="")
		printf("{txt}table %f: table header is '{res:%s}'\n", t, th)
		printf("{txt}table %f: row headers\n", t)
		rc = _collect_get_row_headers(cid, t, rh=J(0,0,""))
		rh
		printf("{txt}table %f: column headers\n", t)
		rc = _collect_get_col_headers(cid, t, ch=J(0,0,""))
		ch
		printf("{txt}table %f: numeric cell items\n", t)
		rc = _collect_get_item_values(cid, t, nv=J(0,0,.))
		nv
		printf("{txt}table %f: string cell items\n", t)
		rc = _collect_get_items(cid, t, sv=J(0,0,""))
		sv
		nrh = cols(rh)
		nch = cols(ch)
		nir = rows(sv)
		nic = cols(sv)
		assert(rows(rh) == nir)
		assert(rows(ch) == nic)
		printf("{txt}table %f: corner block styles\n", t)
		rc = _collect_get_block_styles(
			cid,
			"corner",
			t,
			sty=J(0,2,""))
		sty
		printf("{txt}table %f: row-header block styles\n", t)
		rc = _collect_get_block_styles(
			cid,
			"row-header",
			t,
			sty=J(0,2,""))
		sty
		printf("{txt}table %f: column-header block styles\n", t)
		rc = _collect_get_block_styles(
			cid,
			"column-header",
			t,
			sty=J(0,2,""))
		sty
		printf("{txt}table %f: item block styles\n", t)
		rc = _collect_get_block_styles(
			cid,
			"item",
			t,
			sty=J(0,2,""))
		sty
		for (i=1; i<=nch; i++) {
		for (j=1; j<=nrh; j++) {
			printf("{txt}table %f: corner cell[%f,%f] styles\n",
				t, i, j)
			rc = _collect_get_corner_styles(
				cid,
				i,
				j,
				t,
				sty=J(0,2,""))
			sty
		}
		}
		for (i=1; i<=nir; i++) {
		for (j=1; j<=nrh; j++) {
			printf("{txt}table %f: row-header cell[%f,%f] styles\n",
				t, i, j)
			rc = _collect_get_row_header_styles(
				cid,
				i,
				j,
				t,
				sty=J(0,2,""))
			sty
		}
		}
		for (i=1; i<=nch; i++) {
		for (j=1; j<=nic; j++) {
			printf("{txt}table %f: column-header cell[%f,%f] styles\n",
				t, j, i)
			rc = _collect_get_col_header_styles(
				cid,
				j,
				i,
				t,
				sty=J(0,2,""))
			sty
		}
		}
		for (i=1; i<=nir; i++) {
		for (j=1; j<=nic; j++) {
			printf("{txt}table %f: item cell[%f,%f] styles\n",
				t, i, j)
			rc = _collect_get_item_styles(
				cid,
				i,
				j,
				t,
				sty=J(0,2,""))
			sty
		}
		}
	}
}

end

* end: show_details.mata
