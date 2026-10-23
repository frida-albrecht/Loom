module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-197> : tensor<8x8xi32>}> : () -> tensor<8x8xi32>
    %1 = "tosa.const"() <{values = dense<-79> : tensor<1x8xi32>}> : () -> tensor<1x8xi32>
    %2 = "tosa.const"() <{values = dense<-1.615600e+02> : tensor<1x6x1x5xf32>}> : () -> tensor<1x6x1x5xf32>
    %3 = "tosa.const"() <{values = dense<-1.150000e+02> : tensor<1x1x1x5xf32>}> : () -> tensor<1x1x1x5xf32>
    %4 = tosa.intdiv %0, %1 : (tensor<8x8xi32>, tensor<1x8xi32>) -> tensor<8x8xi32>
    %5 = tosa.pow %2, %3 : (tensor<1x6x1x5xf32>, tensor<1x1x1x5xf32>) -> tensor<1x6x1x5xf32>
    %cast = tensor.cast %4 : tensor<8x8xi32> to tensor<*xi32>
    %cast_0 = tensor.cast %5 : tensor<1x6x1x5xf32> to tensor<*xf32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}

