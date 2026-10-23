#map = affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, d3)>
#map1 = affine_map<(d0, d1, d2, d3) -> (d2, d0, d3, d1)>
module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-54> : tensor<3x1x4x2xi16>}> : () -> tensor<3x1x4x2xi16>
    %cst = arith.constant dense<[[[[0, 1, 2, 3], [4, 5, 6, 7], [8, 9, 10, 11]], [[12, 13, 14, 15], [16, 17, 18, 19], [20, 21, 22, 23]]]]> : tensor<1x2x3x4xi16>
    %1 = linalg.generic {indexing_maps = [#map, #map1], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%cst : tensor<1x2x3x4xi16>) outs(%0 : tensor<3x1x4x2xi16>) {
    ^bb0(%in: i16, %out: i16):
      linalg.yield %in : i16
    } -> tensor<3x1x4x2xi16>
    %cast = tensor.cast %1 : tensor<3x1x4x2xi16> to tensor<*xi16>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    return
  }
}

