module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.790000e+01> : tensor<6x4x4x9xf32>}> : () -> tensor<6x4x4x9xf32>
    %1 = "tosa.const"() <{values = dense<-6> : tensor<9x5x5x3xi32>}> : () -> tensor<9x5x5x3xi32>
    %2 = "tosa.const"() <{values = dense<116> : tensor<1x1x1x1xi32>}> : () -> tensor<1x1x1x1xi32>
    %3 = tosa.sigmoid %0 : (tensor<6x4x4x9xf32>) -> tensor<6x4x4x9xf32>
    %4 = tosa.ceil %3 : (tensor<6x4x4x9xf32>) -> tensor<6x4x4x9xf32>
    %5 = tosa.identity %4 : (tensor<6x4x4x9xf32>) -> tensor<6x4x4x9xf32>
    %6 = tosa.intdiv %1, %2 : (tensor<9x5x5x3xi32>, tensor<1x1x1x1xi32>) -> tensor<9x5x5x3xi32>
    %cast = tensor.cast %5 : tensor<6x4x4x9xf32> to tensor<*xf32>
    %cast_0 = tensor.cast %6 : tensor<9x5x5x3xi32> to tensor<*xi32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI32(%cast_0) : (tensor<*xi32>) -> ()
    return
  }
}

