#map = affine_map<(d0, d1, d2) -> (d1, d0, d2)>
#map1 = affine_map<(d0, d1, d2) -> (d1, d2)>
#map2 = affine_map<(d0, d1, d2) -> (d0, d2, d1)>
module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<113> : tensor<210x6x4xi32>}> : () -> tensor<210x6x4xi32>
    %1 = "tosa.const"() <{values = dense<-59> : tensor<210x4xi32>}> : () -> tensor<210x4xi32>
    %2 = tensor.empty() : tensor<6x4x210xi32>
    %3 = linalg.generic {indexing_maps = [#map, #map1, #map2], iterator_types = ["parallel", "parallel", "parallel"]} ins(%0, %1 : tensor<210x6x4xi32>, tensor<210x4xi32>) outs(%2 : tensor<6x4x210xi32>) {
    ^bb0(%in: i32, %in_0: i32, %out: i32):
      %4 = linalg.index 0 : index
      %5 = linalg.index 1 : index
      %6 = linalg.index 2 : index
      %7 = arith.addi %in, %in_0 : i32
      %8 = arith.index_cast %4 : index to i32
      %9 = arith.addi %7, %8 : i32
      %10 = arith.index_cast %5 : index to i32
      %11 = arith.addi %9, %10 : i32
      %12 = arith.index_cast %6 : index to i32
      %13 = arith.addi %11, %12 : i32
      linalg.yield %13 : i32
    } -> tensor<6x4x210xi32>
    %expanded = tensor.expand_shape %3 [[0, 1], [2], [3, 4, 5]] output_shape [2, 3, 4, 5, 6, 7] : tensor<6x4x210xi32> into tensor<2x3x4x5x6x7xi32>
    %cast = tensor.cast %expanded : tensor<2x3x4x5x6x7xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

