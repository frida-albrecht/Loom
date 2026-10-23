module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.955800e+02> : tensor<3x3x4x3xf32>}> : () -> tensor<3x3x4x3xf32>
    %1 = "tosa.const"() <{values = dense<-56> : tensor<5xi32>}> : () -> tensor<5xi32>
    %2 = "tosa.const"() <{values = dense<151> : tensor<5xi32>}> : () -> tensor<5xi32>
    %3 = tosa.log %0 : (tensor<3x3x4x3xf32>) -> tensor<3x3x4x3xf32>
    %4 = tosa.intdiv %1, %2 : (tensor<5xi32>, tensor<5xi32>) -> tensor<5xi32>
    %cast = tensor.cast %3 : tensor<3x3x4x3xf32> to tensor<*xf32>
    %cast_0 = tensor.cast %4 : tensor<5xi32> to tensor<*xi32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI32(%cast_0) : (tensor<*xi32>) -> ()
    return
  }
}

