module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-5.834000e+01> : tensor<7x3x1xf32>}> : () -> tensor<7x3x1xf32>
    %1 = "tosa.const"() <{values = dense<143> : tensor<4x6x2xi32>}> : () -> tensor<4x6x2xi32>
    %2 = "tosa.const"() <{values = dense<44> : tensor<4x1x1xi32>}> : () -> tensor<4x1x1xi32>
    %3 = tosa.sigmoid %0 : (tensor<7x3x1xf32>) -> tensor<7x3x1xf32>
    %4 = tosa.intdiv %1, %2 : (tensor<4x6x2xi32>, tensor<4x1x1xi32>) -> tensor<4x6x2xi32>
    %5 = tosa.log %3 : (tensor<7x3x1xf32>) -> tensor<7x3x1xf32>
    %6 = tosa.argmax %4 {axis = 1 : i32} : (tensor<4x6x2xi32>) -> tensor<4x2xi32>
    %7 = tosa.pow %5, %3 : (tensor<7x3x1xf32>, tensor<7x3x1xf32>) -> tensor<7x3x1xf32>
    %8 = tosa.add %7, %5 : (tensor<7x3x1xf32>, tensor<7x3x1xf32>) -> tensor<7x3x1xf32>
    %cast = tensor.cast %6 : tensor<4x2xi32> to tensor<*xi32>
    %cast_0 = tensor.cast %8 : tensor<7x3x1xf32> to tensor<*xf32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}

