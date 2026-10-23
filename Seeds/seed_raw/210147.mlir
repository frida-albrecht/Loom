module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-74.4199981> : tensor<8x6xf32>}> : () -> tensor<8x6xf32>
    %1 = "tosa.const"() <{values = dense<-8.099000e+01> : tensor<8x1xf32>}> : () -> tensor<8x1xf32>
    %2 = tosa.pow %0, %1 : (tensor<8x6xf32>, tensor<8x1xf32>) -> tensor<8x6xf32>
    %3 = tosa.log %2 : (tensor<8x6xf32>) -> tensor<8x6xf32>
    %4 = tosa.concat %3, %2 {axis = 1 : i32} : (tensor<8x6xf32>, tensor<8x6xf32>) -> tensor<8x12xf32>
    %cast = tensor.cast %4 : tensor<8x12xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

