///|
/// Entry point for the CLI or runnable program in this template.
/// Keep main focused; move logic into the library package.
/// Run with `moon run cmd/main` from the project root.
fn main {
  let ranks = 8
  let bytes = 4096
  let link = @mooncomm.LinkModel::new(500, 1000)
  let rounds = @mooncomm.tree_rounds(ranks)
  let estimated_ns = @mooncomm.estimate_tree_time_ns(ranks, bytes, link)
  println("MoonComm deterministic collective communication estimator")
  println("ranks=\{ranks}, bytes=\{bytes}, algorithm=balanced-tree")
  println("rounds=\{rounds}, estimated_ns=\{estimated_ns}")
}
