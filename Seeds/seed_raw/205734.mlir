module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<16> : tensor<10x9x5xi8>}> : () -> tensor<10x9x5xi8>
    %1 = "tosa.const"() <{values = dense<3> : tensor<10x5x3xi8>}> : () -> tensor<10x5x3xi8>
    %2 = "tosa.const"() <{values = dense<-1.693700e+02> : tensor<8x4x10x8xf32>}> : () -> tensor<8x4x10x8xf32>
    %3 = "tosa.const"() <{values = dense<0> : tensor<1xi8>}> : () -> tensor<1xi8>
    %4 = "tosa.const"() <{values = dense<0> : tensor<1xi8>}> : () -> tensor<1xi8>
    %5 = tosa.matmul %0, %1, %3, %4 : (tensor<10x9x5xi8>, tensor<10x5x3xi8>, tensor<1xi8>, tensor<1xi8>) -> tensor<10x9x3xi8>
    %6 = tosa.exp %2 : (tensor<8x4x10x8xf32>) -> tensor<8x4x10x8xf32>
    %cast = tensor.cast %5 : tensor<10x9x3xi8> to tensor<*xi8>
    %cast_0 = tensor.cast %6 : tensor<8x4x10x8xf32> to tensor<*xf32>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}

