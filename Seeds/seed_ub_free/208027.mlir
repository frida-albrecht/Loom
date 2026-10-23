module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-12> : tensor<i8>}> : () -> tensor<i8>
    %1 = "tosa.const"() <{values = dense<-10> : tensor<i8>}> : () -> tensor<i8>
    %2 = "tosa.const"() <{values = dense<90.0899963> : tensor<3x4x8xf32>}> : () -> tensor<3x4x8xf32>
    %3 = "tosa.const"() <{values = dense<-179> : tensor<3x10x6x3xi32>}> : () -> tensor<3x10x6x3xi32>
    %4 = "tosa.const"() <{values = dense<130> : tensor<1x10x6x3xi32>}> : () -> tensor<1x10x6x3xi32>
    %5 = tosa.bitwise_or %0, %1 : (tensor<i8>, tensor<i8>) -> tensor<i8>
    %6 = tosa.sigmoid %2 : (tensor<3x4x8xf32>) -> tensor<3x4x8xf32>
    %7 = tosa.floor %6 : (tensor<3x4x8xf32>) -> tensor<3x4x8xf32>
    %8 = tosa.intdiv %3, %4 : (tensor<3x10x6x3xi32>, tensor<1x10x6x3xi32>) -> tensor<3x10x6x3xi32>
    %9 = tosa.tanh %6 : (tensor<3x4x8xf32>) -> tensor<3x4x8xf32>
    %10 = tosa.ceil %7 : (tensor<3x4x8xf32>) -> tensor<3x4x8xf32>
    %cast = tensor.cast %5 : tensor<i8> to tensor<*xi8>
    %cast_0 = tensor.cast %8 : tensor<3x10x6x3xi32> to tensor<*xi32>
    %cast_1 = tensor.cast %9 : tensor<3x4x8xf32> to tensor<*xf32>
    %cast_2 = tensor.cast %10 : tensor<3x4x8xf32> to tensor<*xf32>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    call @printMemrefI32(%cast_0) : (tensor<*xi32>) -> ()
    call @printMemrefF32(%cast_1) : (tensor<*xf32>) -> ()
    call @printMemrefF32(%cast_2) : (tensor<*xf32>) -> ()
    return
  }
}

