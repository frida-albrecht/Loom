module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.879700e+02> : tensor<10x10x4x1xf32>}> : () -> tensor<10x10x4x1xf32>
    %1 = "tosa.const"() <{values = dense<-17> : tensor<5xi8>}> : () -> tensor<5xi8>
    %2 = "tosa.const"() <{values = dense<-12> : tensor<1xi8>}> : () -> tensor<1xi8>
    %3 = tosa.exp %0 : (tensor<10x10x4x1xf32>) -> tensor<10x10x4x1xf32>
    %4 = tosa.logical_left_shift %1, %2 : (tensor<5xi8>, tensor<1xi8>) -> tensor<5xi8>
    %cast = tensor.cast %3 : tensor<10x10x4x1xf32> to tensor<*xf32>
    %cast_0 = tensor.cast %4 : tensor<5xi8> to tensor<*xi8>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI8(%cast_0) : (tensor<*xi8>) -> ()
    return
  }
}

