module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-5.150000e+01> : tensor<16xf32>}> : () -> tensor<16xf32>
    %1 = "tosa.const"() <{values = dense<-5.016000e+01> : tensor<16xf32>}> : () -> tensor<16xf32>
    %transposed = linalg.transpose ins(%0 : tensor<16xf32>) outs(%1 : tensor<16xf32>) permutation = [0] 
    %cast = tensor.cast %transposed : tensor<16xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

