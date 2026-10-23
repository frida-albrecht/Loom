#map = affine_map<(d0) -> (d0)>
#map1 = affine_map<(d0, d1) -> (d0)>
#map2 = affine_map<(d0, d1) -> (d1)>
module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<53> : tensor<5000xi64>}> : () -> tensor<5000xi64>
    %1 = "tosa.const"() <{values = dense<149> : tensor<5000xi32>}> : () -> tensor<5000xi32>
    %c1_i32 = arith.constant 1 : i32
    %2 = linalg.generic {indexing_maps = [#map], iterator_types = ["parallel"]} outs(%0 : tensor<5000xi64>) {
    ^bb0(%out: i64):
      %5 = linalg.index 0 : index
      %6 = arith.index_cast %5 : index to i64
      linalg.yield %6 : i64
    } -> tensor<5000xi64>
    %3 = tensor.empty() : tensor<5000xi32>
    %4 = linalg.generic {indexing_maps = [#map1, #map2], iterator_types = ["parallel", "parallel"]} ins(%2 : tensor<5000xi64>) outs(%3 : tensor<5000xi32>) {
    ^bb0(%in: i64, %out: i32):
      %5 = arith.index_cast %in : i64 to index
      %extracted = tensor.extract %1[%5] : tensor<5000xi32>
      linalg.yield %extracted : i32
    } -> tensor<5000xi32>
    %cast = tensor.cast %4 : tensor<5000xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

