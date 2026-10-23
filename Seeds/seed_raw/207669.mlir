module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-15> : tensor<4xi8>}> : () -> tensor<4xi8>
    %1 = "tosa.const"() <{values = dense<16> : tensor<4xi8>}> : () -> tensor<4xi8>
    %2 = tosa.sub %0, %1 : (tensor<4xi8>, tensor<4xi8>) -> tensor<4xi8>
    %3 = tosa.clamp %2 {max_val = 55 : i8, min_val = -44 : i8} : (tensor<4xi8>) -> tensor<4xi8>
    %cast = tensor.cast %3 : tensor<4xi8> to tensor<*xi8>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    return
  }
}

