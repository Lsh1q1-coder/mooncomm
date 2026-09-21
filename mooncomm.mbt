///|
/// Collective operations supported by MoonComm's initial model.
pub enum Collective {
  Scatter
  Broadcast
  AllGather
  AllReduce
}

///|
pub fn supported_collectives() -> Array[Collective] {
  [Scatter, Broadcast, AllGather, AllReduce]
}

///|
/// A simple alpha-beta link model.
///
/// `latency_ns` is the fixed cost of one transfer. `bandwidth_bytes_per_us`
/// is the usable payload bandwidth. Integer units keep estimates deterministic
/// across all MoonBit targets.
pub struct LinkModel {
  latency_ns : Int
  bandwidth_bytes_per_us : Int
}

///|
pub fn LinkModel::new(
  latency_ns : Int,
  bandwidth_bytes_per_us : Int,
) -> LinkModel {
  if latency_ns < 0 {
    abort("latency_ns must be non-negative")
  }
  if bandwidth_bytes_per_us <= 0 {
    abort("bandwidth_bytes_per_us must be positive")
  }
  { latency_ns, bandwidth_bytes_per_us, }
}

///|
/// Return the number of rounds needed by a balanced tree over `ranks` ranks.
pub fn tree_rounds(ranks : Int) -> Int {
  if ranks <= 1 {
    return 0
  }
  let mut covered = 1
  let mut rounds = 0
  while covered < ranks {
    covered = covered * 2
    rounds = rounds + 1
  }
  rounds
}

///|
/// Return the number of communication rounds in ring AllReduce.
pub fn ring_allreduce_rounds(ranks : Int) -> Int {
  if ranks <= 1 {
    0
  } else {
    2 * (ranks - 1)
  }
}

///|
/// Estimate one point-to-point transfer in nanoseconds.
pub fn transfer_time_ns(bytes : Int, model : LinkModel) -> Int {
  if bytes <= 0 {
    return 0
  }
  let payload_ns = (bytes * 1000 + model.bandwidth_bytes_per_us - 1) /
    model.bandwidth_bytes_per_us
  model.latency_ns + payload_ns
}

///|
/// Initial balanced-tree estimate. Contention-aware scheduling is developed in
/// later milestones; this deliberately exposes a small, testable baseline.
pub fn estimate_tree_time_ns(
  ranks : Int,
  bytes_per_transfer : Int,
  model : LinkModel,
) -> Int {
  tree_rounds(ranks) * transfer_time_ns(bytes_per_transfer, model)
}
