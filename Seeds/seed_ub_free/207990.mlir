module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.193000e+01> : tensor<7x4xf32>}> : () -> tensor<7x4xf32>
    %1 = tosa.abs %0 : (tensor<7x4xf32>) -> tensor<7x4xf32>
    %2 = tosa.minimum %1, %1 : (tensor<7x4xf32>, tensor<7x4xf32>) -> tensor<7x4xf32>
    %3 = tosa.pow %2, %1 : (tensor<7x4xf32>, tensor<7x4xf32>) -> tensor<7x4xf32>
    %4 = tosa.argmax %3 {axis = 1 : i32} : (tensor<7x4xf32>) -> tensor<7xi32>
    %5 = tosa.bitwise_and %4, %4 : (tensor<7xi32>, tensor<7xi32>) -> tensor<7xi32>
    %6 = tosa.bitwise_and %5, %5 : (tensor<7xi32>, tensor<7xi32>) -> tensor<7xi32>
    %7 = "tosa.const"() <{values = dense<0> : tensor<1xi32>}> : () -> tensor<1xi32>
    %8 = "tosa.const"() <{values = dense<0> : tensor<1xi32>}> : () -> tensor<1xi32>
    %9 = tosa.negate %6, %7, %8 : (tensor<7xi32>, tensor<1xi32>, tensor<1xi32>) -> tensor<7xi32>
    %cast = tensor.cast %9 : tensor<7xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

