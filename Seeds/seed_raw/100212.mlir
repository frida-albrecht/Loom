#map = affine_map<(d0, d1, d2, d3, d4, d5, d6, d7) -> (d0, d1, d2, d3, d4, d5, d6, d7)>
#map1 = affine_map<(d0, d1, d2, d3, d4, d5, d6, d7) -> (d0, d1, d2)>
#map2 = affine_map<(d0, d1, d2, d3, d4, d5, d6, d7) -> (d3, d4, d5, d6)>
module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-82> : tensor<2x3x4x5x6x7x8x9xi32>}> : () -> tensor<2x3x4x5x6x7x8x9xi32>
    %1 = "tosa.const"() <{values = dense<-134> : tensor<2x3x4xi32>}> : () -> tensor<2x3x4xi32>
    %2 = "tosa.const"() <{values = dense<57> : tensor<5x6x7x8xi32>}> : () -> tensor<5x6x7x8xi32>
    %3 = tensor.empty() : tensor<2x3x4x5x6x7x8x9xi32>
    %4 = linalg.generic {indexing_maps = [#map, #map1, #map2, #map], iterator_types = ["parallel", "parallel", "parallel", "parallel", "parallel", "parallel", "parallel", "parallel"]} ins(%0, %1, %2 : tensor<2x3x4x5x6x7x8x9xi32>, tensor<2x3x4xi32>, tensor<5x6x7x8xi32>) outs(%3 : tensor<2x3x4x5x6x7x8x9xi32>) {
    ^bb0(%in: i32, %in_0: i32, %in_1: i32, %out: i32):
      %5 = linalg.index 0 : index
      %6 = linalg.index 1 : index
      %7 = arith.addi %5, %6 : index
      %8 = linalg.index 2 : index
      %9 = arith.addi %7, %8 : index
      %10 = linalg.index 3 : index
      %11 = arith.addi %9, %10 : index
      %12 = linalg.index 4 : index
      %13 = arith.addi %11, %12 : index
      %14 = linalg.index 5 : index
      %15 = arith.addi %13, %14 : index
      %16 = linalg.index 6 : index
      %17 = arith.addi %15, %16 : index
      %18 = linalg.index 7 : index
      %19 = arith.addi %17, %18 : index
      %20 = arith.index_cast %19 : index to i32
      linalg.yield %20 : i32
    } -> tensor<2x3x4x5x6x7x8x9xi32>
    %collapsed = tensor.collapse_shape %4 [[0], [1, 2], [3], [4, 5, 6], [7]] : tensor<2x3x4x5x6x7x8x9xi32> into tensor<2x12x5x336x9xi32>
    %cast = tensor.cast %collapsed : tensor<2x12x5x336x9xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

