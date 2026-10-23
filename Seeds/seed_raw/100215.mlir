#map = affine_map<(d0, d1) -> (d0, d1)>
#map1 = affine_map<(d0, d1) -> (d0)>
module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<1.893000e+01> : tensor<10x10x20xf32>}> : () -> tensor<10x10x20xf32>
    %c0 = arith.constant 0 : index
    %cst = arith.constant 0.000000e+00 : f32
    %collapsed = tensor.collapse_shape %0 [[0, 1], [2]] : tensor<10x10x20xf32> into tensor<100x20xf32>
    %1 = tensor.empty() : tensor<100xf32>
    %2 = linalg.fill ins(%cst : f32) outs(%1 : tensor<100xf32>) -> tensor<100xf32>
    %3 = linalg.generic {indexing_maps = [#map, #map1], iterator_types = ["parallel", "reduction"]} ins(%collapsed : tensor<100x20xf32>) outs(%2 : tensor<100xf32>) {
    ^bb0(%in: f32, %out: f32):
      %4 = arith.addf %in, %out : f32
      linalg.yield %4 : f32
    } -> tensor<100xf32>
    %cast = tensor.cast %3 : tensor<100xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

