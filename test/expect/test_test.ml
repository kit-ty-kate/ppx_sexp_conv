open! Base

module Simple_grammar = struct
  type t = int [@@deriving_inline sexp_grammar]

  let _ = fun (_ : t) -> ()

  let (t_sexp_grammar : Ppx_sexp_conv_lib.Sexp.Grammar.t) =
    let (_the_generic_group : Ppx_sexp_conv_lib.Sexp.Grammar.generic_group) =
      { implicit_vars = [ "int" ]
      ; ggid          = "\146e\023\249\235eE\139c\132W\195\137\129\235\025"
      ; types         = [ "t", Implicit_var 0 ]
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

  [@@@deriving.end]
end

module Recursive_group = struct
  type 'a t = T of 'a

  and 'a u = U of 'a t option [@@deriving_inline sexp_grammar]

  let _ = fun (_ : 'a t) -> ()
  let _ = fun (_ : 'a u) -> ()

  let ( (t_sexp_grammar : Ppx_sexp_conv_lib.Sexp.Grammar.t)
      , (u_sexp_grammar : Ppx_sexp_conv_lib.Sexp.Grammar.t) )
    =
    let (_the_generic_group : Ppx_sexp_conv_lib.Sexp.Grammar.generic_group) =
      { implicit_vars = [ "option" ]
      ; ggid          = "8ji\128\003\191M\216\210i\174\019\255\149\027\026"
      ; types         =
          [ ( "t"
            , Explicit_bind
                ( [ "a" ]
                , Variant
                    { ignore_capitalization = false
                    ; alts                  = [ "T", [ One (Explicit_var 0) ] ]
                    } ) )
          ; ( "u"
            , Explicit_bind
                ( [ "a" ]
                , Variant
                    { ignore_capitalization = false
                    ; alts                  =
                        [ ( "U"
                          , [ One
                                (Apply
                                   ( Implicit_var 0
                                   , [ Apply (Recursive "t", [ Explicit_var 0 ]) ] ))
                            ] )
                        ]
                    } ) )
          ]
      }
    in
    let (_the_group : Ppx_sexp_conv_lib.Sexp.Grammar.group) =
      { gid            = Ppx_sexp_conv_lib.Lazy_group_id.create ()
      ; apply_implicit = [ option_sexp_grammar ]
      ; generic_group  = _the_generic_group
      }
    in
    let (t_sexp_grammar : Ppx_sexp_conv_lib.Sexp.Grammar.t) = Ref ("t", _the_group)
    and (u_sexp_grammar : Ppx_sexp_conv_lib.Sexp.Grammar.t) = Ref ("u", _the_group) in
    t_sexp_grammar, u_sexp_grammar
  ;;

  let _ = t_sexp_grammar
  and _ = u_sexp_grammar

  [@@@deriving.end]

  (* Avoid unused constructor warnings. *)
  let _ = T ()
  let _ = U None
end

module Functions = struct
  type ('a, 'b) t = 'a -> 'b [@@deriving_inline sexp_grammar]

  let _ = fun (_ : ('a, 'b) t) -> ()

  let (t_sexp_grammar : Ppx_sexp_conv_lib.Sexp.Grammar.t) =
    let (_the_generic_group : Ppx_sexp_conv_lib.Sexp.Grammar.generic_group) =
      { implicit_vars = []
      ; ggid          = "\237\176\024\207\163\194\2081a1\141\027\236;\254T"
      ; types         =
          [ ( "t"
            , Explicit_bind
                ([ "a"; "b" ], Grammar Ppx_sexp_conv_lib.Sexp.Grammar.fun_sexp_grammar) )
          ]
      }
    in
    let (_the_group : Ppx_sexp_conv_lib.Sexp.Grammar.group) =
      { gid            = Ppx_sexp_conv_lib.Lazy_group_id.create ()
      ; apply_implicit = []
      ; generic_group  = _the_generic_group
      }
    in
    let (t_sexp_grammar : Ppx_sexp_conv_lib.Sexp.Grammar.t) = Ref ("t", _the_group) in
    t_sexp_grammar
  ;;

  let _ = t_sexp_grammar

  [@@@end]
end