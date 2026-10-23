module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.659700e+02> : tensor<4xf32>}> : () -> tensor<4xf32>
    %1 = "tosa.const"() <{values = dense<-2.388000e+01> : tensor<1xf32>}> : () -> tensor<1xf32>
    %2 = "tosa.const"() <{values = dense<7> : tensor<i8>}> : () -> tensor<i8>
    %3 = tosa.add %0, %1 : (tensor<4xf32>, tensor<1xf32>) -> tensor<4xf32>
    %4 = tosa.clz %2 : (tensor<i8>) -> tensor<i8>
    %cast = tensor.cast %3 : tensor<4xf32> to tensor<*xf32>
    %cast_0 = tensor.cast %4 : tensor<i8> to tensor<*xi8>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI8(%cast_0) : (tensor<*xi8>) -> ()
    return
  }
}

