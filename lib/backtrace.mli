(***********************************************************************)
(*  v      *   The Coq Proof Assistant  /  The Coq Development Team    *)
(* <O___,, *        INRIA-Rocquencourt  &  LRI-CNRS-Orsay              *)
(*   \VV/  *************************************************************)
(*    //   *      This file is distributed under the terms of the      *)
(*         *       GNU Lesser General Public License Version 2.1       *)
(***********************************************************************)

(** * Low-level management of OCaml backtraces.

  Currently, OCaml manages its backtraces in a very imperative way. That is to
  say, it only keeps track of the stack destroyed by the last raised exception.
  So we have to be very careful when using this module not to do silly things.

  Basically, you need to manually handle the reraising of exceptions. In order
  to do so, each time the backtrace is lost, you must [push] the stack fragment.
  This essentially occurs whenever a [with] handler is crossed.

*)

(** {5 Backtrace information} *)

type location = {
  loc_filename : string;
  loc_line : int;
  loc_start : int;
  loc_end : int;
}
(** OCaml debugging information for function calls. *)

type frame = { frame_location : location option; frame_raised : bool; }
(** A frame contains two informations: its optional physical location, and
    whether it raised the exception or let it pass through. *)

type t = frame list
(** Type of backtraces. They're just stack of frames. [None] indicates that we
    don't care about recording the backtraces. *)

val empty : t
(** Empty frame stack. *)

val push : t -> t
(** Add the current backtrace information to a given backtrace. *)

(** {5 Utilities} *)

val print_frame : frame -> string
(** Represent a frame. *)

(** {5 Exception handling} *)

val record_backtrace : bool -> unit
(** Whether to activate the backtrace recording mechanism. Note that it will
    only work whenever the program was compiled with the [debug] flag. *)

val get_backtrace : exn -> t option
(** Retrieve the optional backtrace coming with the exception. *)

val add_backtrace : exn -> exn
(** Add the current backtrace information to the given exception.

    The intended use case is of the form: {[

    try foo
      with
      | Bar -> bar
      | err -> let err = add_backtrace err in baz

    ]}

    WARNING: any intermediate code between the [with] and the handler may
    modify the backtrace. Yes, that includes [when] clauses. Ideally, what you
    should do is something like: {[

    try foo
      with err ->
        let err = add_backtrace err in
        match err with
        | Bar -> bar
        | err -> baz

    ]}

    I admit that's a bit heavy, but there is not much to do...

*)
