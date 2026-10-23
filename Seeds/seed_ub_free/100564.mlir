#map = affine_map<(d0, d1, d2) -> (d0, d1, d2)>
#map1 = affine_map<(d0, d1, d2) -> (d2)>
module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-9> : tensor<6x5xi32>}> : () -> tensor<6x5xi32>
    %1 = "tosa.const"() <{values = dense<1.926000e+01> : tensor<5xf32>}> : () -> tensor<5xf32>
    %2 = "tosa.const"() <{values = dense<1.441000e+02> : tensor<5xf32>}> : () -> tensor<5xf32>
    %cst = arith.constant 1.000000e+00 : f32
    %cst_0 = arith.constant 7.000000e+00 : f32
    %cst_1 = arith.constant 1.1920929E-7 : f32
    %expanded = tensor.expand_shape %0 [[0, 1], [2]] output_shape [2, 3, 5] : tensor<6x5xi32> into tensor<2x3x5xi32>
    %3 = tensor.empty() : tensor<2x3x5xf32>
    %4 = linalg.generic {indexing_maps = [#map, #map1, #map1, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%expanded, %1, %2 : tensor<2x3x5xi32>, tensor<5xf32>, tensor<5xf32>) outs(%3 : tensor<2x3x5xf32>) {
    ^bb0(%in: i32, %in_2: f32, %in_3: f32, %out: f32):
      %5 = arith.sitofp %in : i32 to f32
      %6 = arith.addf %in_2, %cst_1 : f32
      %7 = arith.divf %cst_0, %6 : f32
      %8 = arith.divf %cst, %7 : f32
      %9 = arith.mulf %5, %8 : f32
      %10 = arith.addf %9, %in_3 : f32
      linalg.yield %10 : f32
    } -> tensor<2x3x5xf32>
    %cast = tensor.cast %4 : tensor<2x3x5xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

