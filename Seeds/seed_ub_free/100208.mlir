#map = affine_map<(d0, d1, d2, d3, d4, d5, d6, d7) -> (d0, d1, d2, d3, d4, d5, d6, d7)>
#map1 = affine_map<(d0, d1, d2, d3, d4, d5, d6, d7) -> (d0, d1, d2)>
#map2 = affine_map<(d0, d1, d2, d3, d4, d5, d6, d7) -> (d3, d4, d5, d6)>
#map3 = affine_map<(d0, d1, d2, d3, d4, d5, d6, d7) -> (d1, d2, d0, d7, d3, d4, d5, d6)>
module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<142> : tensor<2x3x4x5x6x7x8x9xi32>}> : () -> tensor<2x3x4x5x6x7x8x9xi32>
    %1 = "tosa.const"() <{values = dense<153> : tensor<2x3x4xi32>}> : () -> tensor<2x3x4xi32>
    %2 = "tosa.const"() <{values = dense<-76> : tensor<5x6x7x8xi32>}> : () -> tensor<5x6x7x8xi32>
    %3 = tensor.empty() : tensor<2x3x4x5x6x7x8x9xi32>
    %4 = tensor.empty() : tensor<3x4x2x9x5x6x7x8xi32>
    %5:2 = linalg.generic {indexing_maps = [#map, #map1, #map2, #map, #map3], iterator_types = ["parallel", "parallel", "parallel", "parallel", "parallel", "parallel", "parallel", "parallel"]} ins(%0, %1, %2 : tensor<2x3x4x5x6x7x8x9xi32>, tensor<2x3x4xi32>, tensor<5x6x7x8xi32>) outs(%3, %4 : tensor<2x3x4x5x6x7x8x9xi32>, tensor<3x4x2x9x5x6x7x8xi32>) {
    ^bb0(%in: i32, %in_2: i32, %in_3: i32, %out: i32, %out_4: i32):
      %6 = arith.addi %in, %in_2 : i32
      %7 = arith.addi %6, %in_3 : i32
      linalg.yield %7, %7 : i32, i32
    } -> (tensor<2x3x4x5x6x7x8x9xi32>, tensor<3x4x2x9x5x6x7x8xi32>)
    %collapsed = tensor.collapse_shape %5#0 [[0], [1, 2], [3], [4, 5, 6], [7]] : tensor<2x3x4x5x6x7x8x9xi32> into tensor<2x12x5x336x9xi32>
    %collapsed_0 = tensor.collapse_shape %5#1 [[0, 1], [2], [3], [4], [5, 6, 7]] : tensor<3x4x2x9x5x6x7x8xi32> into tensor<12x2x9x5x336xi32>
    %cast = tensor.cast %collapsed : tensor<2x12x5x336x9xi32> to tensor<*xi32>
    %cast_1 = tensor.cast %collapsed_0 : tensor<12x2x9x5x336xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    call @printMemrefI32(%cast_1) : (tensor<*xi32>) -> ()
    return
  }
}

