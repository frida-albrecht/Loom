module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<130> : tensor<5xi16>}> : () -> tensor<5xi16>
    %1 = "tosa.const"() <{values = dense<-52> : tensor<4x4x8x6xi64>}> : () -> tensor<4x4x8x6xi64>
    %2 = "tosa.const"() <{values = dense<-5> : tensor<4x1x8x6xi64>}> : () -> tensor<4x1x8x6xi64>
    %3 = tosa.clz %0 : (tensor<5xi16>) -> tensor<5xi16>
    %4 = tosa.minimum %1, %2 : (tensor<4x4x8x6xi64>, tensor<4x1x8x6xi64>) -> tensor<4x4x8x6xi64>
    %cast = tensor.cast %3 : tensor<5xi16> to tensor<*xi16>
    %cast_0 = tensor.cast %4 : tensor<4x4x8x6xi64> to tensor<*xi64>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    call @printMemrefI64(%cast_0) : (tensor<*xi64>) -> ()
    return
  }
}

