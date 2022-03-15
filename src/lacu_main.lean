import justification 
import Architectural.LACU input.lacu_contract
import Architectural.lang Architectural.proofObligations
import rpo_meta
open interactive LANG PORTS

variable {α : Type}

local infix `OR`:50 := LANG.disj 
local infix `&`:50 := LANG.conj 

set_option pp.structure_instances_qualifier true 

def local_input_name : string := "lacu_input"
def local_strat_name : string := "lacu_strat"
def local_prf_name : string := "lacu_strat_valid"

def preamble : string := "import justification Architectural.LACU input.lacu_contract rpo_meta \n open LANG PORTS \n\n 
local infix `OR`:50 := LANG.disj 
local infix `&`:50 := LANG.conj 
\n\n 
variables Is : Implementations LACU_ARCH_MODEL 
variables Env : Env PORTS"

meta def proof_template (p₁ p₂ : string) : string := 
"\n\n
theorem " ++ local_prf_name ++ " : " ++ p₁ ++ " := \nbegin \n" ++ p₂ ++ "\nend" ++ "\n\n\n" 

meta def evidence_file_template (input_string tscript : string) : string := 
preamble 
++ "\n\n @[reducible] def " ++ local_input_name 
++ " : ArchitectureWithContracts LANG LACU  := "++ input_string
++ "\n\n @[reducible] def "++ local_strat_name 
++ " : Strategy (Trace PORTS) := Contract.strategy " ++ local_input_name ++ " Is Env " 
++ proof_template ("deductive (Trace PORTS) " ++ " (" ++ local_strat_name ++ " Is Env)" ) (tscript)

meta def output (s : string) : io unit := do 
  of ← io.mk_file_handle "src/evidence.lean" io.mode.write, 
  io.fs.write of s.to_char_buffer

theorem archMap 
{Var Φ : Type} [fintype Var] [decidable_eq Var] [AssertionLang Φ Var]
{S : Component Var}
{A : Architecture S}
(Is :
 Π (S' : Component Var), S' ∈ A.subs → Impl Var)
(inpt : ArchitectureWithContracts Φ S) 
(h : A = inpt.to_Architecture)
: Implementations (inpt.to_Architecture) :=
by {rw ← h, exact Is,}

meta def Output (s : string) : io unit := do 
  of ← io.mk_file_handle "src/evidence.lean" io.mode.write, 
  io.fs.write of s.to_char_buffer

meta def driver (input : pexpr) : tactic unit := 
do 
  STRAT ← tactic.to_expr input,
  if STRAT.contains_sorry then tactic.trace "ff" else do  
  match STRAT with 
  | `(ArchitectureWithContracts.mk %%A %%prnt %%map %%prf) := do 
      inpt ← tactic.eval_expr (ArchitectureWithContracts LANG LACU) STRAT,
      input_fmt ← tactic_format_expr STRAT,
      let envc : expr := `(@set.univ (Trace PORTS)),
      let goal := `(deductive (Trace PORTS) (@Contract.mk_strategy LANG _ _ _ _ LACU (%%STRAT))),
      set_goal goal,
      `[apply via_rpo],
      solve_rpo,
      b ← is_solved, 
      match b with 
      | tt := do tactic.trace "tt", 
         input_string ← stringOfFormatExpr STRAT,
          tactic.unsafe_run_io $ Output $ evidence_file_template input_string  "apply via_rpo,\n solve_rpo,"
      | ff := do tactic.trace "ff"
      end 
  | _ := return ()
end


@[user_command]
meta def main
(meta_info : decl_meta_info)
(_ : parse (lean.parser.tk "main")) : lean.parser unit :=
do 
   F ← read "src/input/inputLACU.txt" types.texpr,
   lean.parser.of_tactic $ driver F
. 
 main
