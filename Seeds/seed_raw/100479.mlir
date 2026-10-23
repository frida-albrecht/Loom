#map = affine_map<(d0, d1, d2) -> (d0, d1, d2)>
module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<28> : tensor<1x1x4xi32>}> : () -> tensor<1x1x4xi32>
    %c4 = arith.constant 4 : index
    %c0 = arith.constant 0 : index
    %cst = arith.constant dense<[[0], [1], [2], [3], [4], [5], [6], [7], [8], [9], [10], [11], [12], [13], [14]]> : tensor<15x1xi32>
    %1 = linalg.generic {indexing_maps = [#map], iterator_types = ["parallel", "parallel", "parallel"]} outs(%0 : tensor<1x1x4xi32>) {
    ^bb0(%out: i32):
      %2 = linalg.index 0 : index
      %extracted = tensor.extract %cst[%2, %c0] : tensor<15x1xi32>
      linalg.yield %extracted : i32
    } -> tensor<1x1x4xi32>
    %cast = tensor.cast %1 : tensor<1x1x4xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

