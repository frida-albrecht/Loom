#map = affine_map<(d0, d1) -> (d0, d1)>
#map1 = affine_map<(d0) -> (d0, 1)>
#map2 = affine_map<(d0) -> (d0)>
module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<132> : tensor<2x2xi32>}> : () -> tensor<2x2xi32>
    %1 = tensor.empty() : tensor<2x2xi32>
    %2 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel"]} ins(%0 : tensor<2x2xi32>) outs(%1 : tensor<2x2xi32>) {
    ^bb0(%in: i32, %out: i32):
      %5 = linalg.index 1 : index
      %6 = arith.index_cast %5 : index to i32
      linalg.yield %6 : i32
    } -> tensor<2x2xi32>
    %3 = tensor.empty() : tensor<2xi32>
    %4 = linalg.generic {indexing_maps = [#map1, #map2], iterator_types = ["parallel"]} ins(%2 : tensor<2x2xi32>) outs(%3 : tensor<2xi32>) {
    ^bb0(%in: i32, %out: i32):
      linalg.yield %in : i32
    } -> tensor<2xi32>
    %cast = tensor.cast %4 : tensor<2xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

