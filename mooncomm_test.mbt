///|
test "balanced tree rounds include non-power-of-two rank counts" {
  assert_eq(@mooncomm.tree_rounds(1), 0)
  assert_eq(@mooncomm.tree_rounds(2), 1)
  assert_eq(@mooncomm.tree_rounds(8), 3)
  assert_eq(@mooncomm.tree_rounds(12), 4)
}

///|
test "initial release exposes four collective operations" {
  assert_eq(@mooncomm.supported_collectives().length(), 4)
}

///|
test "ring allreduce has reduce-scatter and allgather phases" {
  assert_eq(@mooncomm.ring_allreduce_rounds(1), 0)
  assert_eq(@mooncomm.ring_allreduce_rounds(4), 6)
}

///|
test "transfer estimate combines fixed latency and payload cost" {
  let link = @mooncomm.LinkModel::new(500, 1000)
  assert_eq(@mooncomm.transfer_time_ns(4096, link), 4596)
  assert_eq(@mooncomm.estimate_tree_time_ns(8, 4096, link), 13788)
}
