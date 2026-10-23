#map = affine_map<(d0, d1, d2) -> (d0, d2)>
#map1 = affine_map<(d0, d1, d2) -> (d1, d2)>
#map2 = affine_map<(d0, d1, d2) -> (d0, d1)>
module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-157> : tensor<4x16xi32>}> : () -> tensor<4x16xi32>
    %1 = "tosa.const"() <{values = dense<154> : tensor<1x16xi32>}> : () -> tensor<1x16xi32>
    %2 = "tosa.const"() <{values = dense<-86> : tensor<4x1xi32>}> : () -> tensor<4x1xi32>
    %3 = linalg.generic {indexing_maps = [#map, #map1, #map2], iterator_types = ["parallel", "parallel", "reduction"]} ins(%0, %1 : tensor<4x16xi32>, tensor<1x16xi32>) outs(%2 : tensor<4x1xi32>) {
    ^bb0(%in: i32, %in_0: i32, %out: i32):
      %4 = linalg.index 0 : index
      %5 = linalg.index 1 : index
      %6 = linalg.index 2 : index
      %7 = arith.addi %4, %5 : index
      %8 = arith.addi %7, %6 : index
      %9 = arith.index_cast %8 : index to i32
      linalg.yield %9 : i32
    } -> tensor<4x1xi32>
    %cast = tensor.cast %3 : tensor<4x1xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

