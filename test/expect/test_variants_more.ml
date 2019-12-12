open Base

[@@@warning "-37"]

module Nested_inside_variant = struct
  type t = A of [ `A of int ] [@@deriving_inline sexp_grammar]

  let _ = fun (_ : t) -> ()

  let (t_sexp_grammar : Ppx_sexp_conv_lib.Sexp.Grammar.t) =
    let (_the_generic_group : Ppx_sexp_conv_lib.Sexp.Grammar.generic_group) =
      { implicit_vars = [ "int" ]
      ; ggid          = ",M\000\188LV\254\"\1732\027Wm\022m)"
      ; types         =
          [ ( "t"
            , Variant
                { ignore_capitalization = false
                ; alts                  =
                    [ ( "A"
                      , [ One
                            (Variant
                               { ignore_capitalization = true
                               ; alts                  = [ "A", [ One (Implicit_var 0) ] ]
                               })
                        ] )
                    ]
                } )
          ]
      }
    in
    let (_the_group : Ppx_sexp_conv_lib.Sexp.Grammar.group) =
      { gid            = Ppx_sexp_conv_lib.Lazy_group_id.create ()
      ; apply_implicit = [ int_sexp_grammar ]
      ; generic_group  = _the_generic_group
      }
    in
    let (t_sexp_grammar : Ppx_sexp_conv_lib.Sexp.Grammar.t) = Ref ("t", _the_group) in
    t_sexp_grammar
  ;;

  let _ = t_sexp_grammar

  [@@@end]
end

module Nested_inside_record = struct
  type t = { a : [ `A of int ] } [@@deriving_inline sexp_grammar]

  let _ = fun (_ : t) -> ()

  let (t_sexp_grammar : Ppx_sexp_conv_lib.Sexp.Grammar.t) =
    let (_the_generic_group : Ppx_sexp_conv_lib.Sexp.Grammar.generic_group) =
      { implicit_vars = [ "int" ]
      ; ggid          = "*d\228\027a\018k\198mT`\152pg\003\227"
      ; types         =
          [ ( "t"
            , Record
                { allow_extra_fields = false
                ; fields             =
                    [ ( "a"
                      , { optional = false
                        ; args     =
                            [ One
                                (Variant
                                   { ignore_capitalization = true
                                   ; alts = [ "A", [ One (Implicit_var 0) ] ]
                                   })
                            ]
                        } )
                    ]
                } )
          ]
      }
    in
    let (_the_group : Ppx_sexp_conv_lib.Sexp.Grammar.group) =
      { gid            = Ppx_sexp_conv_lib.Lazy_group_id.create ()
      ; apply_implicit = [ int_sexp_grammar ]
      ; generic_group  = _the_generic_group
      }
    in
    let (t_sexp_grammar : Ppx_sexp_conv_lib.Sexp.Grammar.t) = Ref ("t", _the_group) in
    t_sexp_grammar
  ;;

  let _ = t_sexp_grammar

  [@@@end]
end