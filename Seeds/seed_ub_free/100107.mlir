#map = affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, d3)>
module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-4.500000e+00> : tensor<1x225x225x3xf32>}> : () -> tensor<1x225x225x3xf32>
    %1 = "tosa.const"() <{values = dense<-1.481400e+02> : tensor<3x3x3x32xf32>}> : () -> tensor<3x3x3x32xf32>
    %2 = "tosa.const"() <{values = dense<4.300000e+01> : tensor<1x112x112x32xf32>}> : () -> tensor<1x112x112x32xf32>
    %c112 = arith.constant 112 : index
    %c32 = arith.constant 32 : index
    %c16 = arith.constant 16 : index
    %c8 = arith.constant 8 : index
    %c4 = arith.constant 4 : index
    %c0 = arith.constant 0 : index
    %cst = arith.constant 0.000000e+00 : f32
    %3 = tensor.empty() : tensor<1x112x112x32xf32>
    %4 = linalg.fill ins(%cst : f32) outs(%3 : tensor<1x112x112x32xf32>) -> tensor<1x112x112x32xf32>
    %5 = linalg.conv_2d_nhwc_hwcf {dilations = dense<1> : tensor<2xi64>, strides = dense<2> : tensor<2xi64>} ins(%0, %1 : tensor<1x225x225x3xf32>, tensor<3x3x3x32xf32>) outs(%4 : tensor<1x112x112x32xf32>) -> tensor<1x112x112x32xf32>
    %6 = scf.for %arg0 = %c0 to %c112 step %c8 iter_args(%arg1 = %4) -> (tensor<1x112x112x32xf32>) {
      %7 = scf.for %arg2 = %c0 to %c112 step %c16 iter_args(%arg3 = %arg1) -> (tensor<1x112x112x32xf32>) {
        %8 = scf.for %arg4 = %c0 to %c32 step %c4 iter_args(%arg5 = %arg3) -> (tensor<1x112x112x32xf32>) {
          %extracted_slice = tensor.extract_slice %5[0, %arg0, %arg2, %arg4] [1, 8, 16, 4] [1, 1, 1, 1] : tensor<1x112x112x32xf32> to tensor<1x8x16x4xf32>
          %extracted_slice_0 = tensor.extract_slice %2[0, %arg0, %arg2, %arg4] [1, 8, 16, 4] [1, 1, 1, 1] : tensor<1x112x112x32xf32> to tensor<1x8x16x4xf32>
          %extracted_slice_1 = tensor.extract_slice %arg5[0, %arg0, %arg2, %arg4] [1, 8, 16, 4] [1, 1, 1, 1] : tensor<1x112x112x32xf32> to tensor<1x8x16x4xf32>
          %9 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%extracted_slice, %extracted_slice_0 : tensor<1x8x16x4xf32>, tensor<1x8x16x4xf32>) outs(%extracted_slice_1 : tensor<1x8x16x4xf32>) {
          ^bb0(%in: f32, %in_2: f32, %out: f32):
            %10 = arith.addf %in, %in_2 : f32
            linalg.yield %10 : f32
          } -> tensor<1x8x16x4xf32>
          %inserted_slice = tensor.insert_slice %9 into %arg5[0, %arg0, %arg2, %arg4] [1, 8, 16, 4] [1, 1, 1, 1] : tensor<1x8x16x4xf32> into tensor<1x112x112x32xf32>
          scf.yield %inserted_slice : tensor<1x112x112x32xf32>
        }
        scf.yield %8 : tensor<1x112x112x32xf32>
      }
      scf.yield %7 : tensor<1x112x112x32xf32>
    }
    %cast = tensor.cast %6 : tensor<1x112x112x32xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

