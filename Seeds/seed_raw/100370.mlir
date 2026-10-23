#map = affine_map<(d0, d1) -> (d0, d1)>
module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<1.457100e+02> : tensor<64x128xf32>}> : () -> tensor<64x128xf32>
    %cst = arith.constant 0.000000e+00 : f32
    %1 = linalg.generic {indexing_maps = [#map], iterator_types = ["parallel", "parallel"]} outs(%0 : tensor<64x128xf32>) {
    ^bb0(%out: f32):
      %2 = arith.maximumf %out, %cst : f32
      linalg.yield %2 : f32
    } -> tensor<64x128xf32>
    %cast = tensor.cast %1 : tensor<64x128xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

