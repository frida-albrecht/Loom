#map = affine_map<(d0, d1, d2, d3, d4, d5, d6, d7) -> (d7, d5, d6, d0, d1, d2, d3, d4)>
#map1 = affine_map<(d0, d1, d2, d3, d4, d5, d6, d7) -> (d5, d6, d0)>
#map2 = affine_map<(d0, d1, d2, d3, d4, d5, d6, d7) -> (d4, d1, d2, d3)>
#map3 = affine_map<(d0, d1, d2, d3, d4, d5, d6, d7) -> (d0, d1, d2, d3, d4, d5, d6, d7)>
module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-31> : tensor<9x7x8x2x3x4x5x6xi32>}> : () -> tensor<9x7x8x2x3x4x5x6xi32>
    %1 = "tosa.const"() <{values = dense<168> : tensor<7x8x2xi32>}> : () -> tensor<7x8x2xi32>
    %2 = "tosa.const"() <{values = dense<69> : tensor<6x3x4x5xi32>}> : () -> tensor<6x3x4x5xi32>
    %3 = tensor.empty() : tensor<2x3x4x5x6x7x8x9xi32>
    %4 = linalg.generic {indexing_maps = [#map, #map1, #map2, #map3], iterator_types = ["parallel", "parallel", "parallel", "parallel", "parallel", "parallel", "parallel", "parallel"]} ins(%0, %1, %2 : tensor<9x7x8x2x3x4x5x6xi32>, tensor<7x8x2xi32>, tensor<6x3x4x5xi32>) outs(%3 : tensor<2x3x4x5x6x7x8x9xi32>) {
    ^bb0(%in: i32, %in_0: i32, %in_1: i32, %out: i32):
      %5 = arith.addi %in, %in_0 : i32
      %6 = arith.addi %5, %in_1 : i32
      linalg.yield %6 : i32
    } -> tensor<2x3x4x5x6x7x8x9xi32>
    %collapsed = tensor.collapse_shape %4 [[0], [1, 2, 3], [4], [5, 6], [7]] : tensor<2x3x4x5x6x7x8x9xi32> into tensor<2x60x6x56x9xi32>
    %cast = tensor.cast %collapsed : tensor<2x60x6x56x9xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

