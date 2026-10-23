#map = affine_map<(d0, d1) -> (d1)>
#map1 = affine_map<(d0, d1) -> (d0, d1)>
module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<3.980000e+00> : tensor<5x6xf32>}> : () -> tensor<5x6xf32>
    %cst = arith.constant 5.000000e+00 : f32
    %extracted_slice = tensor.extract_slice %0[0, 0] [1, 6] [1, 1] : tensor<5x6xf32> to tensor<6xf32>
    %1 = linalg.generic {indexing_maps = [#map, #map1], iterator_types = ["parallel", "parallel"]} ins(%extracted_slice : tensor<6xf32>) outs(%0 : tensor<5x6xf32>) {
    ^bb0(%in: f32, %out: f32):
      %2 = arith.addf %in, %out : f32
      linalg.yield %2 : f32
    } -> tensor<5x6xf32>
    %cast = tensor.cast %1 : tensor<5x6xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

