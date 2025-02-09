(************************************************************************)
(*         *   The Coq Proof Assistant / The Coq Development Team       *)
(*  v      *         Copyright INRIA, CNRS and contributors             *)
(* <O___,, * (see version control and CREDITS file for authors & dates) *)
(*   \VV/  **************************************************************)
(*    //   *    This file is distributed under the terms of the         *)
(*         *     GNU Lesser General Public License Version 2.1          *)
(*         *     (see LICENSE file for the text of the license)         *)
(************************************************************************)

val wit_ring_mod :
  (Constrexpr.constr_expr Ring_ast.ring_mod, unit, unit)
  Genarg.genarg_type

val ring_mod :
  Constrexpr.constr_expr Ring_ast.ring_mod Pcoq.Entry.t

val wit_ring_mods :
  (Constrexpr.constr_expr Ring_ast.ring_mod list, unit, unit)
  Genarg.genarg_type

val ring_mods :
  Constrexpr.constr_expr Ring_ast.ring_mod list Pcoq.Entry.t

val wit_field_mod :
  (Constrexpr.constr_expr Ring_ast.field_mod, unit, unit)
  Genarg.genarg_type

val field_mod :
  Constrexpr.constr_expr Ring_ast.field_mod Pcoq.Entry.t

val wit_field_mods :
  (Constrexpr.constr_expr Ring_ast.field_mod list, unit, unit)
  Genarg.genarg_type

val field_mods :
  Constrexpr.constr_expr Ring_ast.field_mod list Pcoq.Entry.t
