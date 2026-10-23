#map = affine_map<(d0, d1) -> (d0, d1)>
module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.286400e+02> : tensor<264x4xf32>}> : () -> tensor<264x4xf32>
    %cst = arith.constant dense<2.000000e+00> : tensor<264x4xf32>
    %1 = tensor.empty() : tensor<264x4xf32>
    %2 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel", "parallel"]} ins(%0, %cst : tensor<264x4xf32>, tensor<264x4xf32>) outs(%1 : tensor<264x4xf32>) {
    ^bb0(%in: f32, %in_0: f32, %out: f32):
      %3 = arith.mulf %in, %in_0 : f32
      linalg.yield %3 : f32
    } -> tensor<264x4xf32>
    %expanded = tensor.expand_shape %2 [[0, 1], [2]] output_shape [8, 33, 4] : tensor<264x4xf32> into tensor<8x33x4xf32>
    %cast = tensor.cast %expanded : tensor<8x33x4xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

