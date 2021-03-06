*&---------------------------------------------------------------------*
*& Report ZINT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zint.

PARAMETERS: a TYPE int4 OBLIGATORY DEFAULT 100,
            b TYPE int4 OBLIGATORY DEFAULT 100.

FORM add USING a TYPE int4 b TYPE int4 CHANGING cv_result TYPE int4.
  DATA: n TYPE int4 VALUE 0,
        c TYPE int4 VALUE 0.

  DATA: i TYPE int4 VALUE 1.
  DATA: boolean_a TYPE abap_bool,
        boolean_b TYPE abap_bool,
        _a        TYPE int4,
        _b        TYPE int4,
        aa TYPE int4,
        bb TYPE int4.

  DATA(wrapper_one) = zcl_integer=>value_of( 1 ).
  DATA(wrapper_c) = zcl_integer=>value_of( c ).

  aa = a.
  bb = b.
  WHILE i < 1073741824.
    DATA(wrapper_a) = zcl_integer=>value_of( aa ).
    DATA(wrapper_b) = zcl_integer=>value_of( bb ).
    boolean_a = boolc( wrapper_a->and( wrapper_one )->get_raw_value( ) EQ 1 ).
    boolean_b = boolc( wrapper_b->and( wrapper_one )->get_raw_value( ) EQ 1 ).

    _a = COND int4( WHEN boolean_a EQ abap_true THEN 1 ELSE 0 ).
    _b = COND int4( WHEN boolean_b EQ abap_true THEN 1 ELSE 0 ).
    wrapper_a = zcl_integer=>value_of( _a ).
    wrapper_b = zcl_integer=>value_of( _b ).
    wrapper_c = zcl_integer=>value_of( c ).
    DATA(_n_wrapper) = wrapper_a->xor( wrapper_b )->xor( wrapper_c ).
    DATA(b_or_c) = wrapper_b->or( wrapper_c ).
    DATA(b_and_c) = wrapper_b->and( wrapper_c ).
    DATA(_c_wrapper) = wrapper_a->and( b_or_c )->or( b_and_c ).
    c = _c_wrapper->get_raw_value( ).
    DATA(_n_i0_wrapper) = zcl_integer=>value_of( COND int4( WHEN _n_wrapper->get_raw_value( ) > 0 THEN i ELSE 0 ) ).
    DATA(wrapper_n) = zcl_integer=>value_of( n ).
    n = wrapper_n->or( _n_i0_wrapper )->get_raw_value( ).

    wrapper_a = zcl_integer=>value_of( aa ).
    aa = wrapper_a->shift_right( )->get_raw_value( ).

    wrapper_b = zcl_integer=>value_of( bb ).
    bb = wrapper_b->shift_right( )->get_raw_value( ).

    cv_result = n.

    DATA(wrapper_i) = zcl_integer=>value_of( i ).
    wrapper_i->shift_left( ).

    i = wrapper_i->get_raw_value( ).

  ENDWHILE.

ENDFORM.

START-OF-SELECTION.
  DATA: i TYPE int4.

  PERFORM add USING a b CHANGING i.

  WRITE: / i.