#map = affine_map<() -> ()>
module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.886900e+02> : tensor<f32>}> : () -> tensor<f32>
    %1 = "tosa.const"() <{values = dense<-1.901800e+02> : tensor<f32>}> : () -> tensor<f32>
    %2 = "tosa.const"() <{values = dense<-1.376100e+02> : tensor<f32>}> : () -> tensor<f32>
    %3 = "tosa.const"() <{values = dense<-3.417000e+01> : tensor<f32>}> : () -> tensor<f32>
    %4 = "tosa.const"() <{values = dense<6.365000e+01> : tensor<f32>}> : () -> tensor<f32>
    %5 = tensor.empty() : tensor<f32>
    %6 = tensor.empty() : tensor<f32>
    %7:2 = linalg.generic {indexing_maps = [#map, #map, #map, #map, #map], iterator_types = []} ins(%0, %1, %1 : tensor<f32>, tensor<f32>, tensor<f32>) outs(%5, %6 : tensor<f32>, tensor<f32>) {
    ^bb0(%in: f32, %in_0: f32, %in_1: f32, %out: f32, %out_2: f32):
      %9 = arith.addf %in, %in_0 : f32
      %10 = arith.addf %9, %in_1 : f32
      linalg.yield %9, %10 : f32, f32
    } -> (tensor<f32>, tensor<f32>)
    %8 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = []} ins(%7#1, %1 : tensor<f32>, tensor<f32>) outs(%4 : tensor<f32>) {
    ^bb0(%in: f32, %in_0: f32, %out: f32):
      %9 = arith.addf %in, %in_0 : f32
      %10 = arith.addf %9, %in_0 : f32
      linalg.yield %10 : f32
    } -> tensor<f32>
    %cast = tensor.cast %8 : tensor<f32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

