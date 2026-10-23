module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-5.449000e+01> : tensor<128x256xf32>}> : () -> tensor<128x256xf32>
    %1 = "tosa.const"() <{values = dense<-8.257000e+01> : tensor<256x192xf32>}> : () -> tensor<256x192xf32>
    %2 = "tosa.const"() <{values = dense<1.232800e+02> : tensor<128x192xf32>}> : () -> tensor<128x192xf32>
    %c0 = arith.constant 0 : index
    %c256 = arith.constant 256 : index
    %c32 = arith.constant 32 : index
    %cst = arith.constant 0.000000e+00 : f32
    %c128 = arith.constant 128 : index
    %c192 = arith.constant 192 : index
    %c8 = arith.constant 8 : index
    %c16 = arith.constant 16 : index
    %3 = scf.for %arg0 = %c0 to %c128 step %c8 iter_args(%arg1 = %2) -> (tensor<128x192xf32>) {
      %extracted_slice = tensor.extract_slice %0[%arg0, 0] [8, 256] [1, 1] : tensor<128x256xf32> to tensor<8x256xf32>
      %4 = scf.for %arg2 = %c0 to %c192 step %c16 iter_args(%arg3 = %arg1) -> (tensor<128x192xf32>) {
        %extracted_slice_0 = tensor.extract_slice %1[0, %arg2] [256, 16] [1, 1] : tensor<256x192xf32> to tensor<256x16xf32>
        %extracted_slice_1 = tensor.extract_slice %2[%arg0, %arg2] [8, 16] [1, 1] : tensor<128x192xf32> to tensor<8x16xf32>
        %5 = linalg.fill ins(%cst : f32) outs(%extracted_slice_1 : tensor<8x16xf32>) -> tensor<8x16xf32>
        %6 = scf.for %arg4 = %c0 to %c256 step %c32 iter_args(%arg5 = %5) -> (tensor<8x16xf32>) {
          %extracted_slice_2 = tensor.extract_slice %extracted_slice[0, %arg4] [8, 32] [1, 1] : tensor<8x256xf32> to tensor<8x32xf32>
          %extracted_slice_3 = tensor.extract_slice %extracted_slice_0[%arg4, 0] [32, 16] [1, 1] : tensor<256x16xf32> to tensor<32x16xf32>
          %7 = linalg.matmul ins(%extracted_slice_2, %extracted_slice_3 : tensor<8x32xf32>, tensor<32x16xf32>) outs(%arg5 : tensor<8x16xf32>) -> tensor<8x16xf32>
          scf.yield %7 : tensor<8x16xf32>
        }
        %inserted_slice = tensor.insert_slice %6 into %arg3[%arg0, %arg2] [8, 16] [1, 1] : tensor<8x16xf32> into tensor<128x192xf32>
        scf.yield %inserted_slice : tensor<128x192xf32>
      }
      scf.yield %4 : tensor<128x192xf32>
    }
    %cast = tensor.cast %3 : tensor<128x192xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

