module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-9.033000e+01> : tensor<8xf32>}> : () -> tensor<8xf32>
    %1 = "tosa.const"() <{values = dense<80.6699981> : tensor<8xf32>}> : () -> tensor<8xf32>
    %2 = tosa.pow %0, %1 : (tensor<8xf32>, tensor<8xf32>) -> tensor<8xf32>
    %3 = tosa.minimum %2, %2 : (tensor<8xf32>, tensor<8xf32>) -> tensor<8xf32>
    %4 = tosa.exp %3 : (tensor<8xf32>) -> tensor<8xf32>
    %5 = tosa.rsqrt %4 : (tensor<8xf32>) -> tensor<8xf32>
    %6 = tosa.reverse %5 {axis = 0 : i32} : (tensor<8xf32>) -> tensor<8xf32>
    %7 = tosa.sub %6, %2 : (tensor<8xf32>, tensor<8xf32>) -> tensor<8xf32>
    %cast = tensor.cast %7 : tensor<8xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

