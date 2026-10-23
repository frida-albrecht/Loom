#map = affine_map<(d0, d1, d2, d3, d4, d5) -> (d0, d1, d2 * 2 + d4, d3 * 2 + d5)>
#map1 = affine_map<(d0, d1, d2, d3, d4, d5) -> (d4, d5)>
#map2 = affine_map<(d0, d1, d2, d3, d4, d5) -> (d1, d2, d3)>
module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-157> : tensor<1x1x1080x1920x16xi32>}> : () -> tensor<1x1x1080x1920x16xi32>
    %1 = "tosa.const"() <{values = dense<159> : tensor<2x2xi32>}> : () -> tensor<2x2xi32>
    %2 = tensor.empty() : tensor<16x540x960xi32>
    %3 = tensor.empty() : tensor<1x16x1080x1920xi32>
    %unpack = linalg.unpack %0 inner_dims_pos = [1] inner_tiles = [16] into %3 : tensor<1x1x1080x1920x16xi32> -> tensor<1x16x1080x1920xi32>
    %4 = linalg.generic {indexing_maps = [#map, #map1, #map2], iterator_types = ["parallel", "parallel", "parallel", "parallel", "reduction", "reduction"]} ins(%unpack, %1 : tensor<1x16x1080x1920xi32>, tensor<2x2xi32>) outs(%2 : tensor<16x540x960xi32>) {
    ^bb0(%in: i32, %in_0: i32, %out: i32):
      %5 = arith.maxui %in, %in_0 : i32
      linalg.yield %5 : i32
    } -> tensor<16x540x960xi32>
    %cast = tensor.cast %4 : tensor<16x540x960xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

