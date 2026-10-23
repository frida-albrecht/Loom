#map = affine_map<() -> ()>
#map1 = affine_map<(d0) -> ()>
#map2 = affine_map<(d0) -> (d0)>
module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.837700e+02> : tensor<5x1x1xf32>}> : () -> tensor<5x1x1xf32>
    %1 = "tosa.const"() <{values = dense<-160> : tensor<i32>}> : () -> tensor<i32>
    %c0 = arith.constant 0 : index
    %cst = arith.constant dense<1.000000e+00> : tensor<10xf32>
    %2 = tensor.empty() : tensor<f32>
    %3 = linalg.generic {indexing_maps = [#map, #map], iterator_types = []} ins(%1 : tensor<i32>) outs(%2 : tensor<f32>) {
    ^bb0(%in: i32, %out: f32):
      %6 = arith.index_cast %in : i32 to index
      %extracted = tensor.extract %0[%6, %c0, %c0] : tensor<5x1x1xf32>
      linalg.yield %extracted : f32
    } -> tensor<f32>
    %4 = tensor.empty() : tensor<10xf32>
    %5 = linalg.generic {indexing_maps = [#map1, #map2, #map2], iterator_types = ["parallel"]} ins(%3, %cst : tensor<f32>, tensor<10xf32>) outs(%4 : tensor<10xf32>) {
    ^bb0(%in: f32, %in_0: f32, %out: f32):
      %6 = arith.mulf %in, %in_0 : f32
      linalg.yield %6 : f32
    } -> tensor<10xf32>
    %cast = tensor.cast %5 : tensor<10xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

