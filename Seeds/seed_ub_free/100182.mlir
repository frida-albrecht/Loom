module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<1.103700e+02> : tensor<518x518xf32>}> : () -> tensor<518x518xf32>
    %1 = "tosa.const"() <{values = dense<80.5299987> : tensor<518x518xf32>}> : () -> tensor<518x518xf32>
    %2 = "tosa.const"() <{values = dense<-7.611000e+01> : tensor<256x256xf32>}> : () -> tensor<256x256xf32>
    %c0 = arith.constant 0 : index
    %cst = arith.constant 0.000000e+00 : f32
    %cst_0 = arith.constant 1.000000e+00 : f32
    %3 = bufferization.alloc_tensor() : tensor<256x256xf32>
    %4 = linalg.fill ins(%cst : f32) outs(%3 : tensor<256x256xf32>) -> tensor<256x256xf32>
    %extracted_slice = tensor.extract_slice %4[0, 0] [256, 16] [1, 1] : tensor<256x256xf32> to tensor<256x16xf32>
    %5 = linalg.fill ins(%cst_0 : f32) outs(%3 : tensor<256x256xf32>) -> tensor<256x256xf32>
    %extracted_slice_1 = tensor.extract_slice %5[0, 0] [16, 256] [1, 1] : tensor<256x256xf32> to tensor<16x256xf32>
    %6 = linalg.matmul ins(%extracted_slice, %extracted_slice_1 : tensor<256x16xf32>, tensor<16x256xf32>) outs(%2 : tensor<256x256xf32>) -> tensor<256x256xf32>
    %cast = tensor.cast %6 : tensor<256x256xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

