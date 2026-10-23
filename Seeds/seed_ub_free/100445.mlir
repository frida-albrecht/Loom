#map = affine_map<(d0, d1, d2, d3) -> (d0, d1, d3)>
#map1 = affine_map<(d0, d1, d2, d3) -> (d0, d3, d2)>
#map2 = affine_map<(d0, d1, d2, d3) -> (d0, d1, d2)>
#map3 = affine_map<(d0, d1, d2) -> (d0, d2)>
#map4 = affine_map<(d0, d1, d2) -> (d2, d1)>
#map5 = affine_map<(d0, d1, d2) -> (d0, d1)>
module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<1.788900e+02> : tensor<1x6x5xf32>}> : () -> tensor<1x6x5xf32>
    %1 = "tosa.const"() <{values = dense<-5.092000e+01> : tensor<1x5x6xf32>}> : () -> tensor<1x5x6xf32>
    %2 = "tosa.const"() <{values = dense<1.512800e+02> : tensor<4x6xf32>}> : () -> tensor<4x6xf32>
    %3 = "tosa.const"() <{values = dense<4.690000e+00> : tensor<1x6x6xf32>}> : () -> tensor<1x6x6xf32>
    %4 = "tosa.const"() <{values = dense<4.180000e+01> : tensor<4x6xf32>}> : () -> tensor<4x6xf32>
    %5 = "tosa.const"() <{values = dense<9.272000e+01> : tensor<4x2xf32>}> : () -> tensor<4x2xf32>
    %c0 = arith.constant 0 : index
    %c2 = arith.constant 2 : index
    %c6 = arith.constant 6 : index
    %6 = linalg.generic {indexing_maps = [#map, #map1, #map2], iterator_types = ["parallel", "parallel", "parallel", "reduction"]} ins(%0, %1 : tensor<1x6x5xf32>, tensor<1x5x6xf32>) outs(%3 : tensor<1x6x6xf32>) {
    ^bb0(%in: f32, %in_0: f32, %out: f32):
      %8 = arith.mulf %in, %in_0 : f32
      %9 = arith.addf %out, %8 : f32
      linalg.yield %9 : f32
    } -> tensor<1x6x6xf32>
    %7 = scf.for %arg0 = %c0 to %c6 step %c2 iter_args(%arg1 = %4) -> (tensor<4x6xf32>) {
      %extracted_slice = tensor.extract_slice %6[0, 0, %arg0] [1, 6, 2] [1, 1, 1] : tensor<1x6x6xf32> to tensor<6x2xf32>
      %8 = linalg.generic {indexing_maps = [#map3, #map4, #map5], iterator_types = ["parallel", "parallel", "reduction"]} ins(%2, %extracted_slice : tensor<4x6xf32>, tensor<6x2xf32>) outs(%5 : tensor<4x2xf32>) {
      ^bb0(%in: f32, %in_0: f32, %out: f32):
        %9 = arith.mulf %in, %in_0 : f32
        %10 = arith.addf %out, %9 : f32
        linalg.yield %10 : f32
      } -> tensor<4x2xf32>
      %inserted_slice = tensor.insert_slice %8 into %arg1[0, %arg0] [4, 2] [1, 1] : tensor<4x2xf32> into tensor<4x6xf32>
      scf.yield %inserted_slice : tensor<4x6xf32>
    }
    %cast = tensor.cast %7 : tensor<4x6xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

