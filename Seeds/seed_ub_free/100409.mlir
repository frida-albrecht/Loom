#map = affine_map<(d0, d1) -> (d0, d1)>
module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<1.149200e+02> : tensor<58x1xf32>}> : () -> tensor<58x1xf32>
    %1 = "tosa.const"() <{values = dense<1.087200e+02> : tensor<64x128xf32>}> : () -> tensor<64x128xf32>
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    %c16 = arith.constant 16 : index
    %c32 = arith.constant 32 : index
    %cst = arith.constant 0.000000e+00 : f32
    %dim = tensor.dim %1, %c0 : tensor<64x128xf32>
    %dim_0 = tensor.dim %1, %c1 : tensor<64x128xf32>
    %padded = tensor.pad %0 low[4, 60] high[2, 67] {
    ^bb0(%arg0: index, %arg1: index):
      tensor.yield %cst : f32
    } : tensor<58x1xf32> to tensor<64x128xf32>
    %2 = linalg.fill ins(%cst : f32) outs(%1 : tensor<64x128xf32>) -> tensor<64x128xf32>
    %3 = scf.for %arg0 = %c0 to %dim step %c16 iter_args(%arg1 = %2) -> (tensor<64x128xf32>) {
      %4 = scf.for %arg2 = %c0 to %dim_0 step %c32 iter_args(%arg3 = %arg1) -> (tensor<64x128xf32>) {
        %extracted_slice = tensor.extract_slice %padded[%arg0, %arg2] [16, 32] [1, 1] : tensor<64x128xf32> to tensor<16x32xf32>
        %extracted_slice_1 = tensor.extract_slice %1[%arg0, %arg2] [16, 32] [1, 1] : tensor<64x128xf32> to tensor<16x32xf32>
        %extracted_slice_2 = tensor.extract_slice %arg3[%arg0, %arg2] [16, 32] [1, 1] : tensor<64x128xf32> to tensor<16x32xf32>
        %5 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel", "parallel"]} ins(%extracted_slice, %extracted_slice_1 : tensor<16x32xf32>, tensor<16x32xf32>) outs(%extracted_slice_2 : tensor<16x32xf32>) {
        ^bb0(%in: f32, %in_3: f32, %out: f32):
          %6 = arith.addf %in, %in_3 : f32
          linalg.yield %6 : f32
        } -> tensor<16x32xf32>
        %inserted_slice = tensor.insert_slice %5 into %arg3[%arg0, %arg2] [16, 32] [1, 1] : tensor<16x32xf32> into tensor<64x128xf32>
        scf.yield %inserted_slice : tensor<64x128xf32>
      }
      scf.yield %4 : tensor<64x128xf32>
    }
    %cast = tensor.cast %3 : tensor<64x128xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

